use holochain_core_api::Holochain;
use holochain_dna::Dna;
use neon::prelude::*;

pub struct App {
    instance: Holochain,
    hash: String,
}

impl App {
    pub fn start(&mut self) {
        unimplemented!()
    }
}
