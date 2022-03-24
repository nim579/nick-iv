export const scrollTo = (el, callback) => {
  callback(true);

  if (window.requestAnimationFrame) {
    const curr = document.scrollingElement.scrollTop;
    const diff = el.offsetTop - curr;
    const stepSize = diff / 250;
    let start = null;

    const step = time => {
      if (!start) start = time;
      const progress = (time - start) * stepSize;

      if (Math.abs(diff) <= Math.abs(progress)) {
        document.scrollingElement.scrollTop = el.offsetTop;
        callback(false);
      } else {
        document.scrollingElement.scrollTop = curr + progress;
        window.requestAnimationFrame(step);
      }
    };

    window.requestAnimationFrame(step);
  } else {
    window.scroll({
      top: el.offsetTop,
      left: 0,
      behavior: 'smooth'
    });

    callback(false);
  }
};

const getValue = (val) => {
  if (val?.value != null) {
    const { value, callback } = val;
    return { scroll: value, callback };
  } else {
    return { scroll: val || false, callback: function () { } };
  }
};

export const directive = (el, binding) => {
  const value = getValue(binding.value);
  const oldValue = getValue(binding.oldValue);

  if (!value.scroll || value.scroll === oldValue.scroll) return;

  scrollTo(el, value.callback);
};

export const scrollDirective = () => ({
  mounted(el, binding) { directive(el, binding); },
  updated(el, binding) { directive(el, binding); }
});

export default app => {
  app.directive('scroll', scrollDirective());
};
