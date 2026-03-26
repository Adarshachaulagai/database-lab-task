'use client';

import { useEffect, useState, useCallback } from 'react';
import {
  subscribeToProducts,
  deleteProduct,
  type Product,
} from '@/lib/firebaseOperations';
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Spinner } from '@/components/ui/spinner';
import { Empty } from '@/components/ui/empty';
import { toast } from 'sonner';
import { Trash2, Edit2 } from 'lucide-react';

interface ProductTableProps {
  products: Product[];
  isLoading: boolean;
  onEdit: (id: string, data: { name: string; quantity: number }) => void;
}

export default function ProductTable({
  products,
  isLoading,
  onEdit,
}: ProductTableProps) {
  const [deleteLoadingId, setDeleteLoadingId] = useState<string | null>(null);

  const handleDelete = async (id: string) => {
    if (!confirm('Are you sure you want to delete this product?')) {
      return;
    }

    setDeleteLoadingId(id);

    try {
      await deleteProduct(id);
      toast.success('Product deleted successfully!');
    } catch (error) {
      toast.error('Failed to delete product');
      console.error('Error:', error);
    } finally {
      setDeleteLoadingId(null);
    }
  };

  if (isLoading) {
    return (
      <Card>
        <CardContent className="flex justify-center items-center py-8">
          <Spinner className="h-8 w-8" />
        </CardContent>
      </Card>
    );
  }

  if (products.length === 0) {
    return (
      <Card>
        <CardHeader>
          <CardTitle>Products</CardTitle>
        </CardHeader>
        <CardContent>
          <Empty title="No products found" description="Add your first product to get started" />
        </CardContent>
      </Card>
    );
  }

  return (
    <Card>
      <CardHeader>
        <CardTitle>Products ({products.length})</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="overflow-x-auto">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Product Name</TableHead>
                <TableHead className="text-right">Quantity</TableHead>
                <TableHead className="text-right">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {products.map((product) => (
                <TableRow key={product.id}>
                  <TableCell className="font-medium">{product.name}</TableCell>
                  <TableCell className="text-right">{product.quantity}</TableCell>
                  <TableCell className="text-right">
                    <div className="flex gap-2 justify-end">
                      <Button
                        size="sm"
                        variant="outline"
                        onClick={() =>
                          onEdit(product.id, {
                            name: product.name,
                            quantity: product.quantity,
                          })
                        }
                        disabled={deleteLoadingId !== null}
                        className="flex items-center gap-1"
                      >
                        <Edit2 className="h-4 w-4" />
                        Edit
                      </Button>
                      <Button
                        size="sm"
                        variant="destructive"
                        onClick={() => handleDelete(product.id)}
                        disabled={deleteLoadingId === product.id}
                        className="flex items-center gap-1"
                      >
                        {deleteLoadingId === product.id ? (
                          <Spinner className="h-4 w-4" />
                        ) : (
                          <Trash2 className="h-4 w-4" />
                        )}
                        Delete
                      </Button>
                    </div>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      </CardContent>
    </Card>
  );
}
