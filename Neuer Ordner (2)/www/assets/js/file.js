const canvas = document.getElementById("canvas1");
const ctx = canvas.getContext("2d"); // CTX MEANS CONTEXT
ctx.canvas.width  = window.innerWidth;
ctx.canvas.height = window.innerHeight;
let particleArray;

// get mouse mouse position ///////////////////////////////
let mouse = {
	x: null,
	y: null,
  radius: ((canvas.height/80) * (canvas.width/80))
}
window.addEventListener('mousemove', 
	function(event){
		mouse.x = event.x;
		mouse.y = event.y;
});

// create Particle
class Particle {
    constructor(x, y, directionX, directionY, size, color) {
        this.x = x;
        this.y = y;
        this.directionX = directionX;
        this.directionY = directionY;
        this.size = size;
        this.color = color;
        this.speedX = this.directionX;
        this.speedY = this.directionY;
    }
    // create method to draw individual particle
    draw() {
        ctx.beginPath();
        ctx.arc(this.x,this.y,this.size,0,Math.PI * 2, false);

        ctx.fillStyle = '#4cf636';
	    ctx.fill();
    }

    // check particle position, check mouse position, move the paticle, draw the particle
    update() {
        // check if particle is still within canvas
        if (this.x > canvas.width || this.x < 0){
			this.directionX = -this.directionX;
            this.speedX = this.directionX;
	    } if (this.y + this.size > canvas.height || this.y - this.size < 0){
		    this.directionY = -this.directionY;
            this.speedY = this.directionY;
	    }
        // check mouse position/particle position - collision detection
        let dx = mouse.x - this.x;
        let dy = mouse.y - this.y;
        let distance = Math.sqrt(dx*dx + dy*dy);
        if (distance < mouse.radius + this.size){
            if(mouse.x < this.x && this.x < canvas.width - this.size*2){
               this.x+=2;
            }
            if (mouse.x > this.x && this.x > this.size*2){
                this.x-=2;
            }
            if (mouse.y < this.y && this.y < canvas.height - this.size*2){
                this.y+=2;
            }
            if (mouse.y > this.y && this.y > this.size*2){
                this.y-=2;
            }
        }
        // move particle
        this.x += this.directionX;
        this.y += this.directionY;
        // call draw method
        this.draw();
    }
}

// check if particles are close enough to draw line between them
function connect() {
    let opacityValue = 1;
    for (let a = 0; a < particleArray.length; a++) {
        for (let b = a; b < particleArray.length; b++){
            let distance = ((particleArray[a].x - particleArray[b].x) * (particleArray[a].x - particleArray[b].x))
            +   ((particleArray[a].y - particleArray[b].y) * (particleArray[a].y - particleArray[b].y));
            if  (distance < (canvas.width/5) * (canvas.height/5))
            { 
                opacityValue = 1 - (distance/20000)
                ctx.strokeStyle='rgba(77, 216, 43,0.1)';
                ctx.beginPath();
                ctx.lineWidth = 1;
                ctx.moveTo(particleArray[a].x, particleArray[a].y);
                ctx.lineTo(particleArray[b].x, particleArray[b].y);
                ctx.stroke();

            }    
        }
    }
}

// create particle array 
function init(){
    particleArray = [];
    let numberOfParticles = (canvas.height * canvas.width) / 13000;
    for (let i = 0; i < numberOfParticles; i++){
        let size = (Math.random() * 1) + 1;
        let x = (Math.random() * ((innerWidth - size * 2) - (size * 2)) + size * 2)
        let y = (Math.random() * ((innerHeight - size * 2) - (size * 2)) + size * 2)
        let directionX = (Math.random() * 1) - 0.5;
        let directionY = (Math.random() * 1) - 0.5;
        let color = '#a8da33';
        particleArray.push(new Particle(x, y, directionX, directionY, size, color));
    }
}

// create animation loop
function animate(){
	requestAnimationFrame(animate);
	ctx.clearRect(0,0,innerWidth,innerHeight);
	
	for (let i = 0; i < particleArray.length; i++){
		particleArray[i].update();
	}
    connect();
}
init();
animate();


// RESIZE SETTING - empty and refill particle array every time window changes size + change canvas size
window.addEventListener('resize',
	function(){
		canvas.width = innerWidth;
		canvas.height = innerHeight;
        mouse.radius = ((canvas.height/80) * (canvas.width/80));
		init();
	}
)
// 2) SET MOUSE POSITION AS UNDEFINED when it leaves canvas//////
window.addEventListener('mouseout',
	function(){
		mouse.x = undefined;
	    mouse.y = undefined;
        console.log('mouseout');
	}
)

