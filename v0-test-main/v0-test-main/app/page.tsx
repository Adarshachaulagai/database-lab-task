'use client';

import { useEffect, useState } from 'react';
import ProductForm from '@/components/ProductForm';
import ProductTable from '@/components/ProductTable';
import { subscribeToProducts, type Product } from '@/lib/firebaseOperations';
import { Toaster } from 'sonner';

export default function Home() {
  const [products, setProducts] = useState<Product[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editingData, setEditingData] = useState<{
    name: string;
    quantity: number;
  } | null>(null);

  useEffect(() => {
    setIsLoading(true);
    let unsubscribe: (() => void) | undefined;

    try {
      unsubscribe = subscribeToProducts(
        (updatedProducts) => {
          setProducts(updatedProducts);
          setIsLoading(false);
        },
        (error) => {
          setIsLoading(false);
          console.error('Error loading products:', error);
        }
      );
    } catch (error) {
      setIsLoading(false);
      console.error('Error setting up subscription:', error);
    }

    return () => {
      if (unsubscribe) {
        unsubscribe();
      }
    };
  }, []);

  const handleEdit = (id: string, data: { name: string; quantity: number }) => {
    setEditingId(id);
    setEditingData(data);
    // Scroll to form
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const handleFormSubmit = () => {
    setEditingId(null);
    setEditingData(null);
  };

  const handleCancel = () => {
    setEditingId(null);
    setEditingData(null);
  };

  return (
    <main className="min-h-screen bg-background p-4 md:p-8">
      <div className="max-w-4xl mx-auto">
        <div className="mb-8">
          <h1 className="text-4xl font-bold text-foreground mb-2">
            Product Management System
          </h1>
          <p className="text-gray-600">
            Manage your products with ease. Add, edit, and delete products in
            real-time.
          </p>
        </div>

        <ProductForm
          editingId={editingId}
          editingData={editingData}
          onSubmit={handleFormSubmit}
          onCancel={handleCancel}
        />

        <ProductTable
          products={products}
          isLoading={isLoading}
          onEdit={handleEdit}
        />
      </div>

      <Toaster position="top-right" />
    </main>
  );
}
