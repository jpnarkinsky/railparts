let noRivets = false;

let rivetSize = 1;
let rivetOffset = 1.5;
let rivetResolution = 2;
let rivetSpacing = 6;

// create a single rivet head
function rivet({ l }) {
  l = l ? l : rivetSize * 2;
  return cylinder({ r: rivetSize, h: l });
}

// create a row of rivets
//
// @param {Object} params - parameters
// @param {number} params.spacing - rivet spacing
// @param {number} params.l - length of rivet row
// @param {number} params.t - length of rivets
// @returns {Object} row of rivets
function rivetRow({ t, spacing, l }) {
  spacing = (noRivets ? l : (spacing ? spacing : rivetSpacing));
  return union(
    [...Array(l / spacing)].map(
      (_, i) => rivet({ l: t }).rotateX(90).translate(
        [0, 0, spacing / 2 + (i * spacing)]
      )
    )
  );
}

/**
 * @param {Object} params - parameters
 * @param {number} params.w - beam width
 * @param {number} params.h - beam height
 * @param {number} params.l - beam length
 * @param {number} params.t - material thickness
 */
function ubeam({ w, h, l, t }) {
  return difference(
    square({ size: [w, h] }),
    square({ size: [h - t, w - 2 * t] }).translate([0, t])
  ).extrude({ offset: [0, 0, l] })
}

/**
 * @param {Object} params - parameters
 * @param {number} params.b - web thickness
 * @param {number} params.h - beam height
 * @param {number} params.l - beam length
 * @param {number} params.t - flange thickness
 * @param {number} params.w - flang width
 */
function iBeam({ w, t, b, h, l }) {
  return union(
    [
      square({ size: [b, h] }).translate([(w - b) / 2, 0, 0]),
      square({ size: [w, t] }),
      square({ size: [w, t] }).translate([0, (h - t)])
    ]
  ).extrude({ offset: [0, 0, l] });
}

/**
 * @param {Object} params - parameters
 * @param {number} params.h - beam height
 * @param {number} params.l - beam length
 * @param {number} params.t - material thickness
 * @param {number} params.w - beam width
 */
function uBeam({ h, w, l, t }) {
  return difference(
    square({ size: [h, w] }),
    square({ size: [h - t, w - 2 * t] }).translate([0, t])
  ).extrude({ offset: [0, 0, l] })
}

/**
 * 
 * @param {Object} params 
 * @param {number} params.d - column depth
 * @param {number} params.l - column length
 * @param {number} params.t - material thickness
 * @param {number} params.w - column width 
 * @param {number} params.spacing - rivet spacing
 */
function column({ d, l, t, w }) {
  return union(
    rivetRow({ l, spacing: rivetSpacing, t: t * 4 }).translate([t + rivetOffset, w / 4, 0]),
    rivetRow({ l, spacing: rivetSpacing, t: t * 4 }).translate([w - t - rivetOffset, w / 4, 0]),
    rivetRow({ l, spacing: rivetSpacing, t: t * 4 }).translate([t + rivetOffset, d + w / 4, 0]),
    rivetRow({ l, spacing: rivetSpacing, t: t * 4 }).translate([w - t - rivetOffset, d + w / 4, 0]),
    uBeam({ w, h: d / 3, t, l }).rotateZ(-90).translate([0, 4 * t, 0]),
    uBeam({ w, h: d / 3, t, l }).rotateZ(90).translate([d, d - 2 * t, 0]),
    iBeam({ t, w: d, b: t, h: d, l }).translate([0, t, 0])
  )
}

/**
 * @param {Object} params - parameters
 * @param {number} params.b - web thickness
 * @param {number} params.h - beam height
 * @param {number} params.l - beam length
 * @param {number} params.t - flange thickness
 * @param {number} params.w - flang width
 * @param {number} params.ribCount - number of ribs
 */
function rivetGirder(params) {
  let { w, t, b, h, l, ribCount } = params;
  let ribs = [];
  for (let i = 0; i <= ribCount; i = i + 1) {
    ribs.push(
      square({ size: [w, h] })
        .extrude([0, 0, t])
        .translate([0, 0, i * l / ribCount])
    );
    
    ribs.push(
      rivetRow({ spacing: rivetSpacing * 4, l: h, t: t + rivetSize * 2 })
        .rotateX(90)
        .translate([(w - t) / 4, h, (i * l / ribCount) + 2* rivetSize])
    );
    
    ribs.push(
      rivetRow({ spacing: rivetSpacing * 4, l: h, t: t + rivetSize * 2 })
        .rotateX(90)
        .translate([w - (w - t) / 4, h, (i * l / ribCount) + 2* rivetSize])
    );
  }

  return union([
    iBeam(params),
    ...ribs,
    rivetRow({l, t: 3*t}).translate([(w-t)/4, 2*t, 0]),
    rivetRow({l, t: 3*t}).translate([w - (w-t)/4, 2*t, 0]),
  ]);
}



/**
 * @param {Object} params - parameters
 * @param {number} params.width - total width
 * @param {number} params.height - total height
 * @param {number} params.depth - total depth
 * @param {number} params.braceThickness - thickness of bracing and columns
 * @param {number} params.girderThickness - thickness of girder material
 * @param {number} params.girderHeight - girder height
 */
function bent({ width, height, depth, girderHeight, girderThickness, braceThickness }) {
  return union([
    rivetGirder({ w: depth, b: girderThickness, t: braceThickness, h: girderHeight, l: width, ribCount: 3 })
      .rotateX(90)
      .translate([0, 0, height - girderHeight]),
    column({ w: depth, d: depth, l: height, t: braceThickness }),
    column({ w: depth, d: depth, l: height, t: braceThickness })
      .translate([0, -width - depth - braceThickness, 0]),
    brace({ w: width / 6, h: width / 6, d: depth, t: braceThickness, a: width / 24 })
      .rotateX(90)
      .rotateZ(270)
      .translate([depth, 0, height - girderHeight]),
    brace({ w: width / 6, h: width / 6, d: depth, t: braceThickness, a: width / 24 })
      .rotateX(90)
      .rotateZ(90)
      .translate([0, -width, height - girderHeight])
  ]);
}



function main() {
  return union(
      bent({
        width: 18 * 12,
        height: 20 * 12,
        depth: 12,
        braceThickness: 1,
        girderHeight: 6 * 12,
        girderThickness: 2
      }),
      bent({
        width: 18 * 12,
        height: 20 * 12,
        depth: 12,
        braceThickness: 1,
        girderHeight: 6 * 12,
        girderThickness: 2
      }).translate([18*12,0,0])
  )
}
