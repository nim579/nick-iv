import { h } from 'vue';

export const script = {
  render() {
    return h('script', {
      innerHTML: `
        (function (m, e, t, r, i, k, a) {
          m[i] = m[i] || function () { (m[i].a = m[i].a || []).push(arguments) };
          m[i].l = 1 * new Date(); k = e.createElement(t), a = e.getElementsByTagName(t)[0], k.async = 1, k.src = r, a.parentNode.insertBefore(k, a)
        })
          (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

        ym(22330363, "init", {
          clickmap: true,
          trackLinks: true,
          accurateTrackBounce: true
        });
      `
    });
  }
};

export const noscript = {
  render() {
    return h('noscript', {
      innerHTML: `
        <div><img src="https://mc.yandex.ru/watch/22330363" style="position:absolute; left:-9999px;" alt="" /></div>
      `
    });
  }
};
