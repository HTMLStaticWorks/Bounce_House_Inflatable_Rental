/**
 * Main JavaScript for Bounce House Rental
 */

document.addEventListener('DOMContentLoaded', () => {
    // 1. Theme Toggle Logic
    const themeToggles = document.querySelectorAll('.theme-toggle');
    const currentTheme = localStorage.getItem('theme') || 'light';
    
    // Set initial theme
    document.documentElement.setAttribute('data-theme', currentTheme);
    updateThemeIcon(currentTheme);

    themeToggles.forEach(toggle => {
        toggle.addEventListener('click', () => {
            const current = document.documentElement.getAttribute('data-theme');
            const target = current === 'light' ? 'dark' : 'light';
            
            document.documentElement.setAttribute('data-theme', target);
            localStorage.setItem('theme', target);
            updateThemeIcon(target);
        });
    });

    function updateThemeIcon(theme) {
        themeToggles.forEach(toggle => {
            if(theme === 'dark') {
                toggle.innerHTML = '<i class="bi bi-sun-fill"></i>';
            } else {
                toggle.innerHTML = '<i class="bi bi-moon-fill"></i>';
            }
        });
    }

    // 2. RTL Toggle Logic
    const rtlToggles = document.querySelectorAll('.rtl-toggle');
    const currentDir = localStorage.getItem('dir') || 'ltr';
    
    // Set initial dir
    document.documentElement.setAttribute('dir', currentDir);

    rtlToggles.forEach(toggle => {
        toggle.addEventListener('click', () => {
            const current = document.documentElement.getAttribute('dir');
            const target = current === 'ltr' ? 'rtl' : 'ltr';
            
            document.documentElement.setAttribute('dir', target);
            localStorage.setItem('dir', target);
            updateRtlText(target);
        });
    });

    function updateRtlText(dir) {
        rtlToggles.forEach(toggle => {
            toggle.innerHTML = dir === 'rtl' ? 'LTR' : 'RTL';
        });
    }

    // 3. Scroll Reveal Animations (Intersection Observer)
    const animElements = document.querySelectorAll('.fade-up, .zoom-in, .fade-left, .fade-right');
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('in-view');
                // Optional: unobserve if we only want to animate once
                // observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });

    animElements.forEach(el => observer.observe(el));

    // 4. Back to Top Button
    const backToTopBtn = document.getElementById('backToTop');
    if (backToTopBtn) {
        window.addEventListener('scroll', () => {
            if (window.scrollY > 300) {
                backToTopBtn.classList.add('show');
            } else {
                backToTopBtn.classList.remove('show');
            }
        });

        backToTopBtn.addEventListener('click', () => {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    // 5. Update active nav link based on URL
    const navLinks = document.querySelectorAll('.nav-link');
    const currentPath = window.location.pathname.split('/').pop() || 'index.html';
    
    navLinks.forEach(link => {
        const linkPath = link.getAttribute('href');
        if (linkPath === currentPath) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
});
