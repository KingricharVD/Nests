use std::error::Error;
use std::ops::Range;


/// Information about a hash implementation
#[derive(Debug, Eq, PartialEq, Clone)]
pub struct HashInfo {
	/// The name
	pub name: &'static str,
	
	/// The default/selected hash length
	pub hash_len: usize,
	/// the supported hash lengths
	pub hash_len_r: Range<usize>
}


/// A stateless (oneshot) hash interface
pub trait Hash {
	/// Returns information about the hash
	fn info(&self) -> HashInfo;
	
	/// Hashes `data` into `buf` and returns the hash length
	fn hash(&self, buf: &mut[u8], data: &[u8]) -> Result<usize, Box<dyn Error + 'static>>;
}

/// A variable length extension for `Hash`
pub trait VarlenHash: Hash {
	/// Hashes `data` into `buf` and returns the hash length
	fn varlen_hash(&self, buf: &mut[u8], data: &[u8]) -> Result<usize, Box<dyn Error + 'static>>;
}


/// A stateful (streaming) hash interface
pub trait StreamingHash {
	/// Returns information about the hash
	fn info(&self) -> HashInfo;
	
	/// (Re-)initializes the hash state
	fn init(&mut self) -> Result<(), Box<dyn Error + 'static>>;
	/// Adds the data in `input` to the hash state
	fn update(&mut self, input: &[u8]) -> Result<(), Box<dyn Error + 'static>>;
	/// Computes the hash into `buf` and returns the hash length
	fn finish(&mut self, buf: &mut[u8]) -> Result<usize, Box<dyn Error + 'static>>;
}

/// A variable length extension for `StreamingHash`
pub trait StreamingVarlenHash: StreamingHash {
	/// (Re-)initializes the hash state to produce an `hash_len`-sized hash
	fn varlen_init(&mut self, hash_len: usize) -> Result<(), Box<dyn Error + 'static>>;
}