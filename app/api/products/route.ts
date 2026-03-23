import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'

export async function GET() {
  const supabase = await createClient()
  
  const { data: products, error } = await supabase
    .from('products')
    .select('*, categories(*)')
    .order('category_id')
    .order('title')

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 })
  }

  // Agrupar productos por categoría
  const grouped: Record<string, { category: string, code: string, products: typeof products }> = {}
  
  for (const product of products || []) {
    const categoryCode = product.categories?.code || 'otros'
    const categoryName = product.categories?.name || 'Otros'
    
    if (!grouped[categoryCode]) {
      grouped[categoryCode] = {
        category: categoryName,
        code: categoryCode,
        products: []
      }
    }
    grouped[categoryCode].products.push(product)
  }

  return NextResponse.json(grouped)
}
