use std::{ error::Error, ops::Range };


/// Information about a PBKDF implementation
#[derive(Debug, Eq, PartialEq, Clone)]
pub struct PbkdfInfo {
	/// The name
	pub name: &'static str,
	
	/// The supported output lengths
	pub output_len_r: Range<usize>,
	/// The supported password lengths
	pub password_len_r: Range<usize>,
	/// The supported password lengths
	pub salt_len_r: Range<usize>,
	
	/// The default CPU cost
	pub cpu_cost: u64,
	/// The supported CPU costs
	pub cpu_cost_r: Range<usize>,
	
	/// The default memory cost (is `0` if the PBKDF is not memory hard)
	pub memory_cost: u64,
	/// The supported memory costs (is `0..0` if the PBKDF is not memory hard)
	pub memory_cost_r: Range<u64>,
	
	/// The default parallelism (is `0` if the PBKDF does not support parallelism)
	pub parallelism: u64,
	/// The supported parallelism (is `0..0` if the PBKDF does not support parallelism)
	pub parallelism_r: Range<u64>
}


/// A stateless (oneshot) PBKDF interface
pub trait Pbkdf {
	/// Returns information about the PBKDF
	fn info(&self) -> PbkdfInfo;
	
	/// Fills `buf` with key bytes derived from `password` parametrized by `cpu_cost`
	fn derive(&self, buf: &mut[u8], password: &[u8], salt: &[u8], cpu_cost: u64)
		-> Result<(), Box<dyn Error + 'static>>;
}

/// A stateless (oneshot) memory-hard PBKDF interface
pub trait MemoryHardPbkdf: Pbkdf {
	/// Fills `buf` with key bytes derived from `password` parametrized by `cpu_cost`
	fn derive_memory_hard(&self, buf: &mut[u8], password: &[u8], salt: &[u8], cpu_cost: u64,
		memory_cost: u64, parallelism: u64) -> Result<(), Box<dyn Error + 'static>>;
}