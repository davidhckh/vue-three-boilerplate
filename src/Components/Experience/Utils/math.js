import gsap from "gsap";

export const clamp = (number, min, max) => {
  return gsap.utils.clamp(min, max, number);
};

export const lerp = (p1, p2, t) => {
  return gsap.utils.interpolate(p1, p2, t);
};

export const map = (valueToMap, inMin, inMax, outMin, outMax) => {
  return gsap.utils.mapRange(inMin, inMax, outMin, outMax, valueToMap);
};
