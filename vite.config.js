import { defineConfig } from 'vite';
import { fileURLToPath, URL } from 'node:url';
import vue from '@vitejs/plugin-vue';
import svgLoader from 'vite-svg-loader';

const root = fileURLToPath(new URL('.', import.meta.url));

export default defineConfig({
  plugins: [
    vue(),

    svgLoader({
      svgo: true,
      svgoConfig: {
        multipass: true,
        plugins: [
          {
            name: 'preset-default',
            params: {
              overrides: {
                removeViewBox: false,
                cleanupIds: false
              }
            }
          }
        ]
      }
    })
  ],

  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      '~': root
    }
  },

  build: {
    outDir: './dist',
    assetsDir: 'static',
    assetsInlineLimit: 1024
  },

  css: {
    preprocessorOptions: {
      scss: {
        api: 'modern-compiler',
        additionalData: '@use \'@/styles/mixins\' as *;'
      }
    }
  },

  ssgOptions: {
    script: 'async',
    dirStyle: 'flat',
    formatting: 'minify',
    includedRoutes: () => ['/', '/404']
  },

  server: {
    host: '0.0.0.0'
  }
});
