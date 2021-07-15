use std::error::Error;


/// A random number generator
pub trait SecureRng {
	/// Fills `buf` with cryptographically secure random data
	fn random(&mut self, buf: &mut[u8]) -> Result<(), Box<dyn Error + 'static>>;
}

/// A seedable random number generator
pub trait SeedableRng: SecureRng {
	/// Seeds `seed` into the `SeedableRng`
	fn seed(&mut self, seed: &[u8]) -> Result<(), Box<dyn Error + 'static>>;
}

/// A deterministic random number generator
pub trait DeterministicRng: SecureRng {
	/// Reseeds the `DeterministicRng` with `seed`
	fn reseed(&mut self, seed: &[u8]) -> Result<(), Box<dyn Error + 'static>>;
}


/// A algorithm specific key generator to generate a (secret) key
pub trait SecKeyGen {
	/// Generates a new key into `buf` using `rng` and returns the length of the secret key
	fn new_sec_key(&self, buf: &mut[u8], rng: &mut SecureRng)
		-> Result<usize, Box<dyn Error + 'static>>;
}

/// A algorithm specific trait to compute a public key from a secret key
pub trait PubKeyGen {
	/// Computes the public key from `sec_key` into `buf` and returns the length of the public key
	fn get_pub_key(&self, buf: &mut[u8], sec_key: &[u8]) -> Result<usize, Box<dyn Error + 'static>>;
}