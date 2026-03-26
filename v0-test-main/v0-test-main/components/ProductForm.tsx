'use client';

import { useState } from 'react';
import { addProduct, updateProduct, type ProductInput } from '@/lib/firebaseOperations';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Spinner } from '@/components/ui/spinner';
import { toast } from 'sonner';

interface ProductFormProps {
  editingId?: string | null;
  editingData?: { name: string; quantity: number } | null;
  onSubmit: () => void;
  onCancel?: () => void;
}

export default function ProductForm({
  editingId,
  editingData,
  onSubmit,
  onCancel,
}: ProductFormProps) {
  const [name, setName] = useState(editingData?.name || '');
  const [quantity, setQuantity] = useState(
    editingData?.quantity?.toString() || ''
  );
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    // Validation
    if (!name.trim()) {
      toast.error('Product name cannot be empty');
      return;
    }

    const quantityNum = parseInt(quantity, 10);
    if (isNaN(quantityNum) || quantityNum <= 0) {
      toast.error('Quantity must be a positive number');
      return;
    }

    setIsLoading(true);

    try {
      const productData: ProductInput = {
        name: name.trim(),
        quantity: quantityNum,
      };

      if (editingId) {
        await updateProduct(editingId, productData);
        toast.success('Product updated successfully!');
      } else {
        await addProduct(productData);
        toast.success('Product added successfully!');
      }

      // Reset form
      setName('');
      setQuantity('');
      onSubmit();
    } catch (error) {
      toast.error('Failed to save product. Please try again.');
      console.error('Error:', error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <Card className="mb-6">
      <CardHeader>
        <CardTitle>
          {editingId ? 'Edit Product' : 'Add New Product'}
        </CardTitle>
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label htmlFor="name" className="block text-sm font-medium mb-1">
              Product Name
            </label>
            <Input
              id="name"
              type="text"
              placeholder="Enter product name"
              value={name}
              onChange={(e) => setName(e.target.value)}
              disabled={isLoading}
            />
          </div>

          <div>
            <label htmlFor="quantity" className="block text-sm font-medium mb-1">
              Quantity
            </label>
            <Input
              id="quantity"
              type="number"
              placeholder="Enter quantity"
              value={quantity}
              onChange={(e) => setQuantity(e.target.value)}
              disabled={isLoading}
              min="1"
            />
          </div>

          <div className="flex gap-2">
            <Button
              type="submit"
              disabled={isLoading}
              className="flex items-center gap-2"
            >
              {isLoading && <Spinner className="h-4 w-4" />}
              {editingId ? 'Update Product' : 'Add Product'}
            </Button>
            {editingId && onCancel && (
              <Button
                type="button"
                variant="outline"
                onClick={onCancel}
                disabled={isLoading}
              >
                Cancel
              </Button>
            )}
          </div>
        </form>
      </CardContent>
    </Card>
  );
}
