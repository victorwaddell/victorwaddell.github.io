document.addEventListener('DOMContentLoaded', () => {
    // Sticky Navbar that appears on scroll
    const header = document.querySelector('header');
    const landingSection = document.querySelector('.profile-section');

    const observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            header.classList.toggle('header-visible', !entry.isIntersecting);
        });
    }, { threshold: 0.1 });

    observer.observe(landingSection);

    // Function to initialize the 3D image
    const initBasicThreeJS = (containerId, imageUrl) => {
        const container = document.getElementById(containerId);
        if (!container) {
            console.error('Container not found:', containerId);
            return;
        }

        // Set container dimensions and initially hide it
        container.style.width = '10%';
        container.style.height = '100%';
        container.style.visibility = 'hidden';
        container.style.opacity = '0';
        container.style.transition = 'opacity 0.5s ease';

        // Clear any existing content
        container.innerHTML = '';

        // Create the Three.js scene
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, container.clientWidth / container.clientHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });

        camera.position.z = 2.5;
        renderer.setSize(container.clientWidth, container.clientHeight);
        renderer.setClearColor(0x000000, 0);
        container.appendChild(renderer.domElement);

        // Load the texture and create a plane geometry
        const textureLoader = new THREE.TextureLoader();
        textureLoader.load(imageUrl, (texture) => {
            const geometry = new THREE.PlaneGeometry(2.5, 2.5);
            const material = new THREE.MeshBasicMaterial({ map: texture, transparent: true });
            const plane = new THREE.Mesh(geometry, material);
            scene.add(plane);

            // Start the rotation animation
            const animate = () => {
                plane.rotation.y += 0.0025;
                renderer.render(scene, camera);
                requestAnimationFrame(animate);
            };
            animate();
        });

        // Handle window resizing
        window.addEventListener('resize', () => {
            camera.aspect = container.clientWidth / container.clientHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(container.clientWidth, container.clientHeight);
        });
    };

    // Function to handle the activation of job cards
    const activateCard = (card) => {
        // Deactivate all job cards and hide their images
        const allCards = document.querySelectorAll('.job-card');
        allCards.forEach((otherCard) => {
            if (otherCard !== card) {
                otherCard.classList.remove('active');
                otherCard.classList.add('inactive');
                const imageContainer = otherCard.nextElementSibling;
                if (imageContainer) {
                    imageContainer.style.opacity = '0';
                    setTimeout(() => {
                        imageContainer.style.visibility = 'hidden';
                    }, 500); // Match the transition duration
                }
            }
        });

        // Activate the clicked card
        card.classList.add('active');
        card.classList.remove('inactive');
        const imageContainer = card.nextElementSibling;
        if (imageContainer) {
            imageContainer.style.visibility = 'visible';
            imageContainer.style.opacity = '1';
        }
    };

    // Event listeners for job cards
    const jobCards = document.querySelectorAll('.job-card');
    jobCards.forEach((card) => {
        // Initialize 3D images for all job cards on page load
        const jobId = card.getAttribute('id');
        const imageUrl = getImageUrlForJob(jobId);
        const imageContainer = card.nextElementSibling;
        if (imageContainer && imageUrl) {
            initBasicThreeJS(imageContainer.id, imageUrl);
        }

        // Hover effects
        card.addEventListener('mouseenter', () => {
            const imageContainer = card.nextElementSibling;
            if (imageContainer && !card.classList.contains('active')) {
                imageContainer.style.visibility = 'visible';
                imageContainer.style.opacity = '1';
            }
        });

        card.addEventListener('mouseleave', () => {
            const imageContainer = card.nextElementSibling;
            if (imageContainer && !card.classList.contains('active')) {
                imageContainer.style.opacity = '0';
                setTimeout(() => {
                    if (!card.classList.contains('active')) {
                        imageContainer.style.visibility = 'hidden';
                    }
                }, 500); // Match the transition duration
            }
        });

        // Click to activate
        card.addEventListener('click', () => {
            activateCard(card);
        });
    });

    // Ensure the active card's 3D image is visible on page load
    const activeCard = document.querySelector('.job-card.active');
    if (activeCard) {
        const imageContainer = activeCard.nextElementSibling;
        if (imageContainer) {
            imageContainer.style.visibility = 'visible';
            imageContainer.style.opacity = '1';
        }
    }

    function getImageUrlForJob(jobId) {
        switch (jobId) {
            case 'job-1':
                return 'assets/product-management-icon.png';
            case 'job-2':
                return 'assets/cyber.png';
            case 'job-3':
                return 'assets/information-systems-icon.png';
            default:
                return '';
        }
    }
});
