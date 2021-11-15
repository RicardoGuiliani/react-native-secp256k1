# react-native-secp256k1

bitcoin-core/secp256k1 working with react-native.

Using https://github.com/bitcoin-core/secp256k1 for iOS.
Using https://github.com/ACINQ/secp256k1/tree/master/src/java for Android.

## Installation

## it needs: brew install autoconf automake libtool on mac to build c dependencies

1. `$ npm install RicardoGuiliani/react-native-secp256k1`

2. `$ mkdir node_modules/react-native-secp256k1/android/external && cd node_modules/react-native-secp256k1/android/external && git clone https://github.com/ACINQ/secp256k1.git`

3. `$ cd ../../../../`

4. `$ cd ios && pod install --no-repo-update`

5. `$ cd .. && cp node_modules/react-native-secp256k1/c/selftest.h ios/Pods/bitcoin-core-secp256k1/src/`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-secp256k1` and add `RNSecp256k1.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNSecp256k1.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`

-  Add `import com.reactlibrary.RNSecp256k1Package;` to the imports at the top of the file
-  Add `new RNSecp256k1Package()` to the list returned by the `getPackages()` method

2. Append the following lines to `android/settings.gradle`:
   ```
   include ':react-native-secp256k1'
   project(':react-native-secp256k1').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-secp256k1/android')
   ```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
   ```
     compile project(':react-native-secp256k1')
   ```

## Usage

```javascript
import secp256k1 from "react-native-secp256k1";

async function main() {
   // private secret keys
   const privA = await secp256k1.ext.generateKey();
   const privB = await secp256k1.ext.generateKey();

   //  public keys
   const pubA = await secp256k1.computePubkey(privA, true);
   const pubB = await secp256k1.computePubkey(privB, true);

   //  derive shared secret
   const secretA = await RNSecp256k1.createECDHSecret(privA, pubB);
   const secretB = await RNSecp256k1.createECDHSecret(privB, pubA);

   // sign verify
   const data = "1H1SJuGwoSFTqNI8wvVWEdGRpBvTnzLckoZ1QTF7gI0"; // <------ base64 encode from sha256 32-bit
   const sigA = await secp256k1.sign(data, privA);
   console.log("verify: ", await secp256k1.verify(data, sigA, pubA));

   // ecdh && aes256
   const encryped1 = await secp256k1.ext.encryptECDH(privA, pubB, "Hello World");
   const decryped1 = await secp256k1.ext.decryptECDH(privB, pubA, encryped1);
   console.log(decryped1);

   // all: https://github.com/RicardoGuiliani/react-native-secp256k1-demo
}

main()
   .then(() => {
      console.log("Done");
   })
   .catch((err) => {
      console.error(err);
   });
```
