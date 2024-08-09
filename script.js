// Profile Image Carousel
document.addEventListener('DOMContentLoaded', () => {
    function initProfileCarousel() {
        const carousel = document.querySelector('.profile-carousel');
        const slides = document.querySelectorAll('.profile-carousel-slide');
        let currentIndex = 0;

        const changeSlide = () => {
            slides.forEach((slide, index) => {
                slide.style.transform = `translateX(-${currentIndex * 100}%)`;
            });

            currentIndex = (currentIndex + 1) % slides.length;
        };

        setInterval(changeSlide, 8000); // Change slide every 8 seconds
    }

    initProfileCarousel();
});

// Job Experience Carousel
document.addEventListener('DOMContentLoaded', () => {
    function initJobCarousel() {
        const carousel = document.querySelector('.job-carousel');
        const items = document.querySelectorAll('.job-carousel-item');
        const nextButton = document.querySelector('.carousel-control.next');
        const prevButton = document.querySelector('.carousel-control.prev');

        let currentIndex = 0;

        function updateCarousel() {
            items.forEach((item, index) => {
                item.classList.remove('active');
                if (index === currentIndex) {
                    item.classList.add('active');
                } else {
                    item.style.transform = index < currentIndex ? `translateX(-100%)` : `translateX(100%)`;
                }
            });
            carousel.style.transform = `translateX(-${currentIndex * 100}%)`;
        }

        function nextSlide() {
            currentIndex = (currentIndex + 1) % items.length;
            updateCarousel();
        }

        function prevSlide() {
            currentIndex = (currentIndex - 1 + items.length) % items.length;
            updateCarousel();
        }

        nextButton.addEventListener('click', nextSlide);
        prevButton.addEventListener('click', prevSlide);

        // Touch swipe for mobile
        let startX, endX;

        carousel.addEventListener('touchstart', (e) => {
            startX = e.touches[0].clientX;
        });

        carousel.addEventListener('touchmove', (e) => {
            endX = e.touches[0].clientX;
        });

        carousel.addEventListener('touchend', () => {
            if (startX - endX > 50) nextSlide();
            if (endX - startX > 50) prevSlide();
        });

        updateCarousel();
    }

    initJobCarousel();

    // Three.js functionality for job image
    const initThreeJS = (containerId, imageUrl) => {
        const container = document.getElementById(containerId);
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, container.clientWidth / container.clientHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });

        renderer.setSize(container.clientWidth, container.clientHeight);
        renderer.setClearColor(0x000000, 0);
        container.appendChild(renderer.domElement);

        // Create multiple layers to simulate depth
        const textureLoader = new THREE.TextureLoader();
        textureLoader.load(imageUrl, (texture) => {
            const layerCount = 30;
            const layerDistance = 0.005;
            
            for (let i = 0; i < layerCount; i++) {
                const geometry = new THREE.PlaneGeometry(1.5, 1.5);
                const material = new THREE.MeshBasicMaterial({ map: texture, transparent: true, side: THREE.DoubleSide });
                const plane = new THREE.Mesh(geometry, material);
                plane.position.z = -i * layerDistance;
                scene.add(plane);
            }

            camera.position.z = 5; // Camera

            let rotationY = 0;
            let direction = 1;
            const maxRotation = 0.6; // Maximum rotation angle in radians
            const animate = () => {
                requestAnimationFrame(animate);

                rotationY += direction * 0.001; // Rotation increment

                if (rotationY > maxRotation || rotationY < -maxRotation) {
                    direction *= -1;
                }
                scene.rotation.y = rotationY;

                renderer.render(scene, camera);
            };

            animate();
        }, undefined, (error) => {
            console.error('An error occurred loading the texture:', error);
        });

        window.addEventListener('resize', () => {
            camera.aspect = container.clientWidth / container.clientHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(container.clientWidth, container.clientHeight);
        });
    };

    initThreeJS('job-image-section-1', 'assets/product-management-icon.png');
    initThreeJS('job-image-section-2', 'assets/cyber.png');
    initThreeJS('job-image-section-3', 'assets/information-systems-icon.png');
});

// Fade-in effect for sections
const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
        if (entry.isIntersecting) {
            entry.target.classList.add('in-view');
        } else {
            entry.target.classList.remove('in-view');
        }
    });
}, { threshold: 0.1 });

document.querySelectorAll('section').forEach((section) => {
    observer.observe(section);
});

// Blur effect based on scroll position
window.addEventListener('scroll', () => {
    const sections = document.querySelectorAll('section');
    const viewportHeight = window.innerHeight;

    sections.forEach(section => {
        const rect = section.getBoundingClientRect();
        const distanceFromCenter = Math.abs(rect.top + rect.height / 2 - viewportHeight / 2);
        const blurValue = Math.min(distanceFromCenter / 500, 5); // Blur area
        section.style.filter = `blur(${blurValue}px)`;
    });
});
