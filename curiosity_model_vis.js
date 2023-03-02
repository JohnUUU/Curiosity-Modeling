function drawArrow(ctx, fromx, fromy, tox, toy, arrowWidth, color) {
    var headlen = 7;
    var angle = Math.atan2(toy - fromy, tox - fromx);
    ctx.save();
    ctx.strokeStyle = color;
    ctx.beginPath();
    ctx.moveTo(fromx, fromy);
    ctx.lineTo(tox, toy);
    ctx.lineWidth = arrowWidth;
    ctx.stroke();
    ctx.beginPath();
    ctx.moveTo(tox, toy);
    ctx.lineTo(tox - headlen * Math.cos(angle - Math.PI / 7),
        toy - headlen * Math.sin(angle - Math.PI / 7));
    ctx.lineTo(tox - headlen * Math.cos(angle + Math.PI / 7),
        toy - headlen * Math.sin(angle + Math.PI / 7));
    ctx.lineTo(tox, toy);
    ctx.lineTo(tox - headlen * Math.cos(angle - Math.PI / 7),
        toy - headlen * Math.sin(angle - Math.PI / 7));
    ctx.fill();
    ctx.restore();
}

ctx = canvas.getContext("2d");
ctx.clearRect(0, 0, canvas.width, canvas.height);

dots = Dot
const area = dots.tuples().length
const n = Math.sqrt(area)
for (const ind in dots.tuples()) {
    const dot = dots.tuples()[ind]
    const r = +dot.join(row).toString()
    const c = +dot.join(col).toString()
    ctx.beginPath();
    ctx.arc(canvas.width / (2 * n) + c * canvas.width / n, canvas.width / (8 * n) + r * canvas.width / (4 * n), 1, 0, 2 * Math.PI);
    ctx.fill();
    if (dot.join(next).toString() != '') {
        const nextDot = dot.join(next)
        const nr = +nextDot.join(row).toString()
        const nc = +nextDot.join(col).toString()
        console.log(dot.toString(), nextDot.toString())
        console.log(r, c, nr, nc)
        drawArrow(ctx, canvas.width / (2 * n) + c * canvas.width / n,
            canvas.width / (8 * n) + r * canvas.width / (4 * n),
            canvas.width / (2 * n) + nc * canvas.width / n,
            canvas.width / (8 * n) + nr * canvas.width / (4 * n), 1, 'red');
    }
}


