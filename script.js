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

    // Word map animation
    const words = document.querySelectorAll('.word');
    const containerHeight = document.querySelector('.word-map-container').offsetHeight;
    const wordCount = words.length;

    const primaryHue = 220;
    const primarySaturation = '57%';

    const verticalSpacing = containerHeight / wordCount;

    words.forEach((word, index) => {
        const startPosY = index * verticalSpacing;
        const delay = index * 1;
        word.style.top = `${startPosY}px`;
        word.style.animationDelay = `${delay}s`;

        const randomDuration = 10 + Math.random() * 15;
        word.style.animationDuration = `${randomDuration}s`;

        const lightness = 50 + Math.random() * 40;
        word.style.backgroundColor = `hsl(${primaryHue}, ${primarySaturation}, ${lightness}%)`;
    });

    // Function to determine if the background color is light, medium, or dark
    function getColorCategory(color) {
        const tempElement = document.createElement('div');
        tempElement.style.color = color;
        document.body.appendChild(tempElement);
        const computedColor = window.getComputedStyle(tempElement).color;
        document.body.removeChild(tempElement);

        // Extract RGB values
        const rgb = computedColor.match(/\d+/g).map(Number);

        // Calculate brightness (using the formula for luminance)
        const brightness = (0.299 * rgb[0] + 0.587 * rgb[1] + 0.114 * rgb[2]) / 255;
        
        if (brightness > 0.75) return 'light';
        if (brightness > 0.5) return 'medium-light';
        if (brightness > 0.25) return 'medium-dark';
        return 'dark';
    }

    // Apply different text colors based on background brightness
    document.querySelectorAll('.word').forEach(word => {
        const bgColor = window.getComputedStyle(word).backgroundColor;
        const colorCategory = getColorCategory(bgColor);
        
        switch (colorCategory) {
            case 'light':
                word.style.color = '#0b2545';
                break;
            case 'medium-light':
                word.style.color = '#1a4e8a';
                break;
            case 'medium-dark':
                word.style.color = '#d1e0ff';
                break;
            case 'dark':
                word.style.color = '#ffffff';
                break;
        }
    });

    // Rotating Scotty Dog in the About Section
    const initScottyDog = () => {
        const scottyContainer = document.getElementById('scotty-dog-container');
        if (!scottyContainer) return;

        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, scottyContainer.clientWidth / scottyContainer.clientHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });

        camera.position.z = 2.25;
        renderer.setSize(scottyContainer.clientWidth, scottyContainer.clientHeight);
        renderer.setClearColor(0x000000, 0);
        scottyContainer.appendChild(renderer.domElement);

        const textureLoader = new THREE.TextureLoader();
        textureLoader.load('assets/cmu-scotty-scarf-left-800w.png', (texture) => {
            const geometry = new THREE.PlaneGeometry(2.5, 2.5);

            const material = new THREE.MeshPhongMaterial({
                map: texture,
                shininess: 60,
                transparent: true,
                side: THREE.DoubleSide,
            });

            const plane = new THREE.Mesh(geometry, material);
            scene.add(plane);

            const ambientLight = new THREE.AmbientLight(0xffffff, 0.2);
            const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
            directionalLight.position.set(1, 1, 1).normalize();
            scene.add(ambientLight);
            scene.add(directionalLight);

            const rotationSpeed = 0.001;
            const maxRotation = 0.4;
            let direction = -1;

            const animate = () => {
                plane.rotation.y += direction * rotationSpeed;
                if (plane.rotation.y > maxRotation || plane.rotation.y < -maxRotation) {
                    direction *= -1;
                }
                renderer.render(scene, camera);
                requestAnimationFrame(animate);
            };
            animate();

            window.addEventListener('resize', () => {
                camera.aspect = scottyContainer.clientWidth / scottyContainer.clientHeight;
                camera.updateProjectionMatrix();
                renderer.setSize(scottyContainer.clientWidth, scottyContainer.clientHeight);
            });
        });
    };

    initScottyDog();

    // Three.js initialization for job card images
    let activeInitialization = null;
    
    const initBasicThreeJS = (containerId, imageUrl) => {
        const container = document.getElementById(containerId);
        if (!container) {
            console.error('Container not found:', containerId);
            return;
        }

        if (activeInitialization) {
            clearTimeout(activeInitialization);
            activeInitialization = null;
        }

        container.innerHTML = '';
        container.style.width = '10%';
        container.style.height = '100%';
        container.style.visibility = 'hidden';
        container.style.opacity = '0';
        container.style.transition = 'opacity 0.5s ease';

        activeInitialization = setTimeout(() => {
            const scene = new THREE.Scene();
            const camera = new THREE.PerspectiveCamera(75, container.clientWidth / container.clientHeight, 0.1, 1000);
            const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });

            camera.position.z = 2.75;
            renderer.setSize(container.clientWidth, container.clientHeight);
            renderer.setClearColor(0x000000, 0);
            container.appendChild(renderer.domElement);

            const textureLoader = new THREE.TextureLoader();
            textureLoader.load(imageUrl, (texture) => {
                const geometry = new THREE.PlaneGeometry(2.5, 2.5);

                const material = new THREE.MeshPhongMaterial({
                    map: texture,
                    shininess: 60,
                    transparent: true,
                    side: THREE.DoubleSide,
                });

                const plane = new THREE.Mesh(geometry, material);
                scene.add(plane);

                const ambientLight = new THREE.AmbientLight(0xffffff, 0.2);
                const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
                directionalLight.position.set(1, 1, 1).normalize();
                scene.add(ambientLight);
                scene.add(directionalLight);

                let direction = -1;
                const rotationSpeed = 0.001;
                const maxRotation = 0.4;

                const animate = () => {
                    plane.rotation.y += direction * rotationSpeed;
                    if (plane.rotation.y > maxRotation || plane.rotation.y < -maxRotation) {
                        direction *= -1;
                    }
                    renderer.render(scene, camera);
                    requestAnimationFrame(animate);
                };
                animate();

                container.style.visibility = 'visible';
                container.style.opacity = '1';
            });

            window.addEventListener('resize', () => {
                camera.aspect = container.clientWidth / container.clientHeight;
                camera.updateProjectionMatrix();
                renderer.setSize(container.clientWidth, container.clientHeight);
            });

            activeInitialization = null;
        }, 200);
    };

    // Function to handle the activation of job cards
    const activateCard = (card) => {
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
                    }, 500);
                }
            }
        });

        card.classList.add('active');
        card.classList.remove('inactive');
        const imageContainer = card.nextElementSibling;
        if (imageContainer) {
            initBasicThreeJS(imageContainer.id, getImageUrlForJob(card.getAttribute('id')));
            imageContainer.style.visibility = 'visible';
            imageContainer.style.opacity = '1';
        }
    };

    // Event listeners for job cards
    const jobCards = document.querySelectorAll('.job-card');
    jobCards.forEach((card) => {
        const jobId = card.getAttribute('id');
        const imageUrl = getImageUrlForJob(jobId);
        const imageContainer = card.nextElementSibling;
        if (imageContainer && imageUrl) {
            initBasicThreeJS(imageContainer.id, imageUrl);
        }

        card.addEventListener('click', () => {
            activateCard(card);
        });
    });

    // Ensure the active card's 3D image is visible on page load
    const activeCard = document.querySelector('.job-card.active');
    if (activeCard) {
        const imageContainer = activeCard.nextElementSibling;
        if (imageContainer) {
            initBasicThreeJS(imageContainer.id, getImageUrlForJob(activeCard.getAttribute('id')));
            imageContainer.style.visibility = 'visible';
            imageContainer.style.opacity = '1';
        }
    }

    // Get image URL for job card
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

    // Project modal functionality
    const projectCards = document.querySelectorAll('.project-card');
    const modal = document.getElementById('project-modal');
    const closeBtn = document.querySelector('.close-btn');
    const modalTitle = document.getElementById('modal-title');
    const modalDescription = document.getElementById('modal-description');
    const modalLink = document.getElementById('modal-link');

    const projects = [
        {
            title: "Baking Company Dashboard Mockup",
            description: "A dashboard mockup for a baking company, showcasing order tracking, inventory management, and sales analytics.",
            link: "assets/projects/Baking Company Dashboard Mockup.pdf"
        },
        {
            title: "Cooking App Prototype",
            description: "An interactive prototype for a cooking app featuring recipe search, instructions, and social sharing capabilities.",
            link: "assets/projects/Cooking App Prototype.pdf"
        },
        {
            title: "Entity Relationship Diagram",
            description: "A detailed ERD representing the relationships between different entities in a database, crucial for understanding data structures.",
            link: "assets/projects/Entity Relationship Diagram.pdf"
        },
        {
            title: "Generative AI Proposal",
            description: "A proposal for incorporating generative AI into IT processes, focusing on efficiency improvements and automation.",
            link: "assets/projects/Generative AI Proposal.pdf"
        },
        {
            title: "Software Documentation for Company",
            description: "Comprehensive software documentation covering installation, usage, and maintenance for a company's internal tools.",
            link: "assets/projects/Software Documentation for Company.pdf"
        },
        {
            title: "Travel App Prototype",
            description: "A prototype for a travel app, providing AI-driven trip planning based on user preferences and integrated services.",
            link: "assets/projects/Travel App Prototype.pdf"
        },
        {
            title: "User Flow Diagram for Company",
            description: "A user flow diagram illustrating the process flow within a company's application, highlighting user interactions and decision points.",
            link: "assets/projects/User Flow Diagram for Company.pdf"
        },
        {
            title: "Freshman Year Webapp",
            description: "A web application developed during freshman year, showcasing basic web development skills and interactive features.",
            link: "assets/projects/Freshman Year Webapp/Index.html"
        },
        {
            title: "Sophomore Year App Dev Project",
            description: "An app development project from sophomore year, focusing on mobile application development and UX design.",
            link: "assets/projects/Sophomore Year App Dev Project"
        },
        {
            title: "Sophomore Year Webapp",
            description: "A more advanced web application from sophomore year, demonstrating improvements in coding and design practices.",
            link: "assets/projects/Sophomore Year Webapp"
        }
    ];

    projectCards.forEach((card) => {
        card.addEventListener('click', () => {
            const projectId = card.getAttribute('data-project');
            const project = projects[projectId - 1];

            modalTitle.innerText = project.title;
            modalDescription.innerText = project.description;
            modalLink.href = project.link;

            modal.style.display = 'flex';
        });
    });

    closeBtn.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
    
});
