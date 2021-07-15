[![License](https://img.shields.io/badge/License-BSD--2--Clause-blue.svg)](https://opensource.org/licenses/BSD-2-Clause)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# Crypto API
This crate defines a general purpose API for various cryptographic primitives. It's goal is to provide an abstraction
layer that allows you to switch your cryptographic backend easily.

## Primitives covered
The following primitives are covered:
 - Ciphers
   - Normal cipher
   - AEAD cipher
   - Streaming API
   
 - Hash
   - Normal hash
   - Variable-length hash
   - Streaming API
   
 - KDF
   - Normal parametrized KDF (tweaked with salt/info)
   
 - MAC
   - Normal MAC
   - Streaming API
   
 - PBKDF
   - Normal (CPU-hard) PBKDF
   - Memory-hard PBKDF
 
 - RNG
   - Cryptographically secure RNG
   - Cryptographically secure, seedable RNG
   - Cryptographically secure, deterministic RNG
 
 - Asymmetric Signer
   - Normal signer