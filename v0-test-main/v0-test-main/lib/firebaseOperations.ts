import {
  collection,
  addDoc,
  updateDoc,
  deleteDoc,
  doc,
  onSnapshot,
  serverTimestamp,
  query,
  orderBy,
} from 'firebase/firestore';
import { db } from './firebase';

export interface Product {
  id: string;
  name: string;
  quantity: number;
  createdAt: any;
}

export interface ProductInput {
  name: string;
  quantity: number;
}

const COLLECTION_NAME = 'products';

// Create a new product
export const addProduct = async (productData: ProductInput): Promise<string> => {
  try {
    const docRef = await addDoc(collection(db, COLLECTION_NAME), {
      ...productData,
      createdAt: serverTimestamp(),
    });
    return docRef.id;
  } catch (error) {
    console.error('Error adding product:', error);
    throw error;
  }
};

// Update an existing product
export const updateProduct = async (
  productId: string,
  productData: ProductInput
): Promise<void> => {
  try {
    const productRef = doc(db, COLLECTION_NAME, productId);
    await updateDoc(productRef, {
      ...productData,
      updatedAt: serverTimestamp(),
    });
  } catch (error) {
    console.error('Error updating product:', error);
    throw error;
  }
};

// Delete a product
export const deleteProduct = async (productId: string): Promise<void> => {
  try {
    await deleteDoc(doc(db, COLLECTION_NAME, productId));
  } catch (error) {
    console.error('Error deleting product:', error);
    throw error;
  }
};

// Subscribe to real-time updates
export const subscribeToProducts = (
  callback: (products: Product[]) => void,
  onError: (error: any) => void
) => {
  try {
    const q = query(
      collection(db, COLLECTION_NAME),
      orderBy('createdAt', 'desc')
    );

    const unsubscribe = onSnapshot(
      q,
      (snapshot) => {
        const products: Product[] = [];
        snapshot.forEach((doc) => {
          products.push({
            id: doc.id,
            name: doc.data().name,
            quantity: doc.data().quantity,
            createdAt: doc.data().createdAt,
          });
        });
        callback(products);
      },
      (error) => {
        console.error('Error fetching products:', error);
        onError(error);
      }
    );

    return unsubscribe;
  } catch (error) {
    console.error('Error setting up subscription:', error);
    onError(error);
  }
};
