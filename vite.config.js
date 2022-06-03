import { defineConfig } from 'vite';
import path from 'path';
import vue from '@vitejs/plugin-vue';
import svgLoader from 'vite-svg-loader';

export default defineConfig(() => {
  return {
    plugins: [
      vue(),

      svgLoader({
        svgoConfig: {
          plugins: [{name: 'removeViewBox', active: false}]
        }
      })
    ],

    resolve: {
      extensions: ['.vue', '.js', '.json', '.less'],
      alias: {
        '@': path.resolve(__dirname, './src')
      }
    },

    build: {
      outDir: './dist',
      assetsDir: './static',
      assetsInlineLimit: 1024
    },

    css: {
      preprocessorOptions: {
        scss: {
          additionalData: `
          @use 'sass:map';
          @use '@/styles/colors';
          @use '@/styles/fonts';
          @use '@/styles/sizes';
          @use '@/styles/ui';
          `
        }
      }
    },

    ssr: {
      noExternal: []
    },

    server: {
      host: '0.0.0.0'
    }
  };
});
