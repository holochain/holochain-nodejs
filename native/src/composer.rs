use app::App;
use base64;
use holochain_dna::Dna;
use neon::prelude::*;
use serde_json;
use std::collections::HashMap;

pub struct Composer {
    dnas: HashMap<String, Dna>,
    app_instances: HashMap<String, App>,
}

declare_types! {

    /// A class for generating greeting strings.
    pub class JsComposer for Composer {
        init(mut _cx) {
            Ok(Composer {
                dnas: HashMap::new(),
                app_instances: HashMap::new(),
            })
        }

        method installApp(mut cx) {
            let raw_app_dna: String = cx.argument::<JsString>(0)?.to_string(&mut cx)?.value();
            let app_dna_json = base64::decode(&raw_app_dna).unwrap();
            let app_dna: Dna = serde_json::from_slice(&app_dna_json[..]).unwrap();

            let mut this = cx.this();

            {
                let guard = cx.lock();
                let mut composer = this.borrow_mut(&guard);

                let hash = app_dna.uuid.to_string();
                composer.dnas.insert(hash, app_dna);
            }

            Ok(cx.undefined().upcast())
        }

        method installedApps(mut cx) {
            let this = cx.this();

            let dnas = {
                let inner_apps = {
                    let guard = cx.lock();
                    let composer = this.borrow(&guard);
                    composer.dnas.clone()
                };

                // Create a new array:
                let array: Handle<JsArray> = cx.empty_array();

                // Push the values into the array:
                for (index, (hash, _)) in inner_apps.iter().enumerate() {
                    let str_val = cx.string(hash);

                    array.set(&mut cx, index as u32, str_val)?;
                }

                array
            };

            Ok(dnas.upcast())
        }
    }

}

register_module!(mut cx, { cx.export_class::<JsComposer>("Composer") });
