var w = window.innerWidth
var h = window.innerHeight

const flightPath = {
    curviness: 1.25,
    autoRotate: true,
    values: [
        { x: 0, y: 0 },
        { x: w * 0.25, y: h * 0.1 },
        { x: w * 0.5, y: h * 0.4 },
        { x: w * 0.7, y: h * 0.6 },
        { x: w * 1.1, y: h },
    ]
}

const tween = new TimelineLite();

tween.add(
    TweenLite.to('.paper-plane', 5, {
        bezier: flightPath,
        ease: Power1.easeInOut
    })
);

const controller = new ScrollMagic.Controller();

const scene = new ScrollMagic.Scene({
        triggerElement: '.animation',
        duration: 2000,
        triggerHook: 0

    })
    .setTween(tween)
    .setPin('.animation')
    .addTo(controller);