use crate::rng::SecKeyGen;
use std::{ error::Error, ops::Range };


/// Information about a MAC implementation
#[derive(Debug, Eq, PartialEq, Clone)]
pub struct MacInfo {
	/// The name
	pub name: &'static str,
	
	/// Indicates if this MAC is a one time MAC (= requires a unique key for each message)
	pub is_otm: bool,
	
	/// The default/selected MAC length
	pub mac_len: usize,
	/// The supported MAC lengths
	pub mac_len_r: Range<usize>,
	/// The supported key lengths
	pub key_len_r: Range<usize>
}


/// A stateless (oneshot) MAC interface
pub trait Mac: SecKeyGen {
	/// Returns information about the MAC
	fn info(&self) -> MacInfo;
	
	/// Authenticates `data` into `buf` using `key` and returns the MAC length
	fn auth(&self, buf: &mut[u8], data: &[u8], key: &[u8])
		-> Result<usize, Box<dyn Error + 'static>>;
}

/// A variable length extension for `Mac`
pub trait VarlenMac: Mac {
	/// Authenticates `data` into `buf` using `key` and returns the MAC length
	fn varlen_auth(&self, buf: &mut[u8], data: &[u8], key: &[u8])
		-> Result<usize, Box<dyn Error + 'static>>;
}


/// A stateful (streaming) MAC interface
pub trait StreamingMac: SecKeyGen {
	/// Returns information about the MAC
	fn info(&self) -> MacInfo;
	
	/// (Re-)initializes the MAC state with `key`
	fn init(&mut self, key: &[u8]) -> Result<(), Box<dyn Error + 'static>>;
	/// Adds the data in `input` to the MAC state
	fn update(&mut self, data: &[u8]) -> Result<(), Box<dyn Error + 'static>>;
	/// Computes the MAC into `buf` and returns the MAC length
	fn finish(&mut self, buf: &mut[u8]) -> Result<usize, Box<dyn Error + 'static>>;
}

/// A variable length extension for `StreamingMac`
pub trait StreamingVarlenMac: StreamingMac {
	/// (Re-)initializes the MAC state with `key` to produce an `mac_len`-sized hash
	fn varlen_init(&mut self, mac_len: usize, key: &[u8]) -> Result<(), Box<dyn Error + 'static>>;
}