/** @type {import('next').NextConfig} */
const nextConfig = {
  // Redirect root to index.html for static site compatibility
  async rewrites() {
    return [
      {
        source: '/',
        destination: '/index.html',
      },
      {
        source: '/catalogo',
        destination: '/catalogo.html',
      },
      {
        source: '/contacto',
        destination: '/contacto.html',
      },
    ];
  },
};

module.exports = nextConfig;
