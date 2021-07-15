//! This crate defines a general purpose API for various cryptographic primitives. It's goal is to
//! provide an abstraction layer that allows you to switch your cryptographic backend easily.

/// Cipher traits
pub mod cipher;
/// Hash traits
pub mod hash;
/// KDF traits
pub mod kdf;
/// MAC traits
pub mod mac;
/// PBKDF traits
pub mod pbkdf;
/// Random number generator traits
pub mod rng;
/// Asymmetric signature traits
pub mod signer;