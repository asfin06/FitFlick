import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  // Products
  Stream<List<Map<String, dynamic>>> getProductsStream() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // Cart
  Stream<List<Map<String, dynamic>>> getCartStream() {
    if (userId == null) return Stream.value([]);
    return _db.collection('users').doc(userId).collection('cart').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  Future<void> addToCart(Map<String, dynamic> product, {String? selectedSize, String? selectedColor}) async {
    if (userId == null) return;
    final String docId = '${product['title']}_${selectedSize ?? ''}_${selectedColor ?? ''}'.replaceAll(' ', '_').toLowerCase();

    final cartRef = _db.collection('users').doc(userId).collection('cart').doc(docId);
    
    try {
      final docSnapshot = await cartRef.get();
      if (docSnapshot.exists) {
        await cartRef.update({
          'quantity': FieldValue.increment(1)
        });
      } else {
        String subtitle = '';
        if (selectedColor != null && selectedSize != null) {
          subtitle = '$selectedColor / Size $selectedSize';
        } else if (selectedSize != null) {
          subtitle = 'Size $selectedSize';
        } else if (selectedColor != null) {
          subtitle = selectedColor;
        } else {
          subtitle = product['subtitle'] ?? 'One Size';
        }
        
        await cartRef.set({
          'title': product['title'],
          'subtitle': subtitle,
          'price': _parsePrice(product['price'].toString()),
          'imageUrl': product['imageUrl'],
          'quantity': 1,
        });
      }
    } catch (e) {
      debugPrint('Error adding to cart: $e');
    }
  }

  Future<void> removeFromCart(String docId) async {
    if (userId == null) return;
    await _db.collection('users').doc(userId).collection('cart').doc(docId).delete();
  }

  Future<void> updateCartQuantity(String docId, int quantity) async {
    if (userId == null) return;
    if (quantity <= 0) {
      await removeFromCart(docId);
      return;
    }
    await _db.collection('users').doc(userId).collection('cart').doc(docId).update({
      'quantity': quantity,
    });
  }
  
  double _parsePrice(String priceString) {
    String cleanString = priceString.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleanString) ?? 0.0;
  }

  // Orders
  Stream<List<Map<String, dynamic>>> getOrdersStream() {
    if (userId == null) return Stream.value([]);
    return _db.collection('users').doc(userId).collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  // User Profile
  Stream<Map<String, dynamic>?> getUserProfileStream() {
    if (userId == null) return Stream.value(null);
    return _db.collection('users').doc(userId).snapshots().map((doc) => doc.data());
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    if (userId == null) return null;
    final doc = await _db.collection('users').doc(userId).get();
    return doc.data();
  }

  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    if (userId == null) return;
    await _db.collection('users').doc(userId).set(data, SetOptions(merge: true));
  }
}
