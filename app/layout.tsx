import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "LP.RIVAS | Equipos de Seguridad Personal",
  description: "Catálogo de equipos de seguridad personal y corporativo. Confección de uniformes de alto rendimiento.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="es">
      <body>{children}</body>
    </html>
  );
}
