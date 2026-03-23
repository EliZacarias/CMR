-- Tabla de categorías de productos
CREATE TABLE IF NOT EXISTS categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  icon TEXT DEFAULT 'package',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla de productos
CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  image_url TEXT NOT NULL,
  description TEXT,
  specs TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Habilitar RLS
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Políticas para categorías (lectura pública, escritura solo autenticados)
CREATE POLICY "categories_select_public" ON categories FOR SELECT USING (true);
CREATE POLICY "categories_insert_auth" ON categories FOR INSERT WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "categories_update_auth" ON categories FOR UPDATE USING (auth.role() = 'authenticated');
CREATE POLICY "categories_delete_auth" ON categories FOR DELETE USING (auth.role() = 'authenticated');

-- Políticas para productos (lectura pública, escritura solo autenticados)
CREATE POLICY "products_select_public" ON products FOR SELECT USING (true);
CREATE POLICY "products_insert_auth" ON products FOR INSERT WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "products_update_auth" ON products FOR UPDATE USING (auth.role() = 'authenticated');
CREATE POLICY "products_delete_auth" ON products FOR DELETE USING (auth.role() = 'authenticated');

-- Insertar categorías iniciales
INSERT INTO categories (code, name, icon) VALUES
  ('overoles', 'Overoles', 'user'),
  ('camisolas', 'Camisolas', 'shirt'),
  ('chamarras', 'Chamarras', 'cloud-rain'),
  ('chalecos', 'Chalecos', 'layers'),
  ('camisas', 'Camisas', 'shirt'),
  ('batas', 'Batas de Laboratorio', 'activity'),
  ('filipinas', 'Filipinas', 'chef-hat'),
  ('uniformes', 'Uniformes Guardias', 'shield-check')
ON CONFLICT (code) DO NOTHING;
