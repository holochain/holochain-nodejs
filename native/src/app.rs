use holochain_agent::Agent;
use holochain_core::{
    context::Context as HolochainContext, logger::Logger, persister::SimplePersister,
};
use holochain_core_api::Holochain;
use holochain_dna::Dna;
use neon::context::Context;
use neon::prelude::*;
use std::sync::{Arc, Mutex};

#[derive(Clone, Debug)]
struct NullLogger {}

impl Logger for NullLogger {
    fn log(&mut self, _msg: String) {}
}

pub struct App {
    instance: Holochain,
    hash: String,
}

declare_types! {
    pub class JsApp for App {
        init(mut ctx) {
            let agent_name = ctx.argument::<JsString>(0)?.to_string(&mut ctx)?.value();
            let dna_data = ctx.argument::<JsString>(1)?.to_string(&mut ctx)?.value();

            let agent = Agent::from_string(agent_name);

            let context = Arc::new(HolochainContext {
                agent,
                logger: Arc::new(Mutex::new(NullLogger {})),
                persister: Arc::new(Mutex::new(SimplePersister::new())),
            });

            let dna = Dna::from_json_str(&dna_data).expect("unable to parse dna data");

            Ok(App {
                instance: Holochain::new(dna, context).or_else(|_| {
                    let error_string = ctx.string("unable to create Holochain");
                    ctx.throw(error_string)
                })?,
                hash: "ab83bae71f53b18d7ea8db36193baf48bf82aff392aab4".into(),
            })
        }

        method start(mut ctx) {
            let mut this = ctx.this();

            let start_res = {
                let guard = ctx.lock();
                let mut app = this.borrow_mut(&guard);

                app.instance.start()
            };

            start_res.or_else(|_| {
                let error_string = ctx.string("unable to start hApp");
                ctx.throw(error_string)
            })?;

            Ok(ctx.undefined().upcast())
        }
    }
}

register_module!(mut ctx, { ctx.export_class::<JsApp>("HolochainApp") });
