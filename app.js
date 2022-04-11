var w = window.innerWidth
var h = window.innerHeight

const flightPath = {
    curviness: 1.25,
    autoRotate: true,
    values: [
        { x: 0, y: 0 },
        { x: w * 0.3, y: h * 0.2 },
        { x: w * 0.5, y: h * 0.4 },
        { x: w * 0.3, y: h * 0.6 },
        { x: w * 0.5, y: h },
    ]
}

const tween = new TimelineLite();

tween.add(
    TweenLite.to('.sabertooth', 5, {
        bezier: flightPath,
        ease: Power1.easeInOut
    })
);

const controller = new ScrollMagic.Controller();

const scene = new ScrollMagic.Scene({
        triggerElement: '.animation',
        duration: 5000,
        triggerHook: 0

    })
    .setTween(tween)
    .setPin('.animation')
    .addTo(controller);

var revealElements = document.getElementsByClassName("tbox");
for (var i = 0; i < revealElements.length; i++) {
    new ScrollMagic.Scene({
            triggerElement: '.animation',
            offset: 600 + 600 * (i * 2),
            triggerHook: 0.5,
        })
        .setClassToggle(revealElements[i], "visible") // add class toggle
        .addTo(controller);
}