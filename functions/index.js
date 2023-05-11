const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const express = require("express");
const bodyParser = require("body-parser");

var app = express();
app.use(bodyParser.json());

var db = admin.firestore();



// exports.notifyNewOrderToRider = functions.firestore
//     .document("orders/{orderId}")
//     .onUpdate(async (change) => {
//         // const order = snapshot.data();
//         const order = change.after.data();
//         const previousData = change.before.data();
//         if (order.orderStatus == "Rider Appointed") {
//             const qurerySnapshot = db
//                 .collection("riders")
//                 .doc(order.deliveryBoy.riderUid)
//                 .collection("tokens")
//                 .get();

//             const token = (await qurerySnapshot).docs.map((snap) => snap.id);
//             const payload = {
//                 notification: {
//                     title: `New Order Recived from ${order.seller.shopName} `,
//                     body: ` Order Total Amount ₹ ${order.total}`,
//                     sound: "default",
//                     clickAction: "FLUTTER_NOTIFICATION_CLICK",
//                 },
//             };
//             return admin.messaging().sendToDevice(token, payload);
//         } else {
//             return null;
//         }
//     });
// exports.notifyNewOrder = functions.firestore
//     .document("listing/{orderId}")
//     .onCreate(async (snapshot) => {
//         const order = snapshot.data();
//         const qurerySnapshot = db
//             .collection("vendors")
//             .doc(order.seller.sellerId)
//             .collection("tokens")
//             .get();

//         const token = (await qurerySnapshot).docs.map((snap) => snap.id);
//         const payload = {
//             notification: {
//                 title: `New Order Recived from ${order.userName} `,
//                 body: ` Order Total Amount ₹ ${order.total}`,
//                 sound: "default",
//                 clickAction: "FLUTTER_NOTIFICATION_CLICK",

//             },
//         };
//         return admin.messaging().sendToDevice(token, payload);
//     });

exports.notifystatusToCustomer = functions.firestore
    .document("listing/{listingId}")
    .onUpdate(async (change) => {

        const listing = change.after.data();
        const qurerySnapshot = db
            .collection("users")
            .doc(listing.createdBy)
            .collection("tokens")
            .get();

        const token = (await qurerySnapshot).docs.map((snap) => snap.id);
        const payload = {
            notification: {
                title: `Listing Update`,
                body: `Your EWaste ${listing.listingStatus}`,
                sound: "default",
                clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
        };
        return admin.messaging().sendToDevice(token, payload);
    });





