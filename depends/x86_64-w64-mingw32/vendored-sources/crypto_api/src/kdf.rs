use std::{ error::Error, ops::Range };


/// Information about a KDF implementation
#[derive(Debug, Eq, PartialEq, Clone)]
pub struct KdfInfo {
	/// The name
	pub name: &'static str,
	
	/// The supported output lengths
	pub output_len_r: Range<usize>,
	/// The supported key lengths
	pub key_len_r: Range<usize>,
	/// The supported salt lengths
	pub salt_len_r: Range<usize>,
	/// The supported info lengths
	pub info_len_r: Range<usize>
}


/// A stateless (oneshot) key derivation interface
pub trait Kdf {
	/// Returns information about the MAC
	fn info(&self) -> KdfInfo;
	
	/// Fills `buf` with key bytes derived from `base_key` with `salt` and `info`
	fn derive(&self, buf: &mut[u8], base_key: &[u8], salt: &[u8], info: &[u8])
		-> Result<(), Box<dyn Error + 'static>>;
}