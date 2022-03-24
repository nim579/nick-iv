const onIntersect = (entries, callback, type) => {
  entries.forEach(entry => {
    if (type === 'full' && entry.isIntersecting) {
      if (entry.intersectionRatio === 1 || entry.rootBounds.height < entry.boundingClientRect.height) {
        callback(true, 1);
      } else {
        callback(true, 0);
      }
    } else if (entry.isIntersecting) {
      callback(true, entry.intersectionRatio);
    } else {
      callback(false, entry.intersectionRatio);
    }
  });
};

const addOvserver = (el, callback, modifiers, root) => {
  if (!root) root = null;
  let rootMargin = '0px';
  let type = 'normal';
  let threshold = [0.75];

  switch (true) {
  case modifiers.exact:
    type = 'exact';
    threshold = [0];
    break;

  case modifiers.full:
    type = 'full';
    threshold = [0, 1];
    break;
  }

  const onEvent = event => onIntersect(event, callback, type);

  const observer = new window.IntersectionObserver(onEvent, { root, rootMargin, threshold });
  observer.observe(el);

  return observer;
};

const directiveUnset = (el, vnode) => {
  if (vnode._viewportObserver) vnode._viewportObserver.unobserve(el);
};

const directiveSet = (el, binding, vnode) => {
  let root = null;
  let callback = binding.value;

  if (binding.value.callback) {
    callback = binding.value.callback;
    root = binding.value.root || null;
  }

  directiveUnset(el, vnode);

  if (typeof callback !== 'function') return;
  if (!window.IntersectionObserver) return callback(null);

  vnode._viewportObserver = addOvserver(el, callback, binding.modifiers, root);
};

export const viewportDirective = () => ({
  mounted(el, binding, vnode) {
    directiveSet(el, binding, vnode);
  },
  updated(el, binding, vnode) {
    directiveSet(el, binding, vnode);
  },
  beforeUnmount(el, binding, vnode) {
    directiveUnset(el, vnode);
  }
});

export default app => {
  app.directive('viewport', viewportDirective());
};
