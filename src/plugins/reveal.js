// v-reveal: fade/slide an element in when it first enters the viewport.
//
// Usage: <div v-reveal> or <div v-reveal="150"> (delay in ms).
// - Does nothing on the server, so the prerendered HTML is fully visible.
// - Elements that are already on screen at mount are not animated (no flash).
// - Without IntersectionObserver the element simply stays visible.

let observer = null;

const getObserver = () => {
  if (observer || typeof IntersectionObserver === 'undefined') return observer;

  observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (!entry.isIntersecting) return;

      entry.target.classList.add('is-revealed');
      observer.unobserve(entry.target);
    });
  }, { rootMargin: '0px 0px -8% 0px', threshold: 0.08 });

  return observer;
};

const directive = {
  mounted(el, binding) {
    const io = getObserver();
    if (!io) return;

    const rect = el.getBoundingClientRect();
    if (rect.top < window.innerHeight * 0.92 && rect.bottom > 0) return;

    if (binding.value) el.style.setProperty('--reveal-delay', `${binding.value}ms`);

    el.classList.add('reveal');
    io.observe(el);
  },

  unmounted(el) {
    if (observer) observer.unobserve(el);
  }
};

export default (app) => {
  app.directive('reveal', directive);
};
