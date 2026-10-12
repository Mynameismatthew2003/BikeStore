import react from '@vitejs/plugin-react'
import { defineConfig } from 'vite'

export default defineConfig({
  plugins: [react()],
  server: {
    // Las peticiones a /api se envían al backend
    proxy: {
      '/api': 'http://localhost:3000',
    },
  },
})
