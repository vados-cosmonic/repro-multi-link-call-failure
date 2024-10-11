mod bindings {
    use crate::Component;
    wit_bindgen::generate!({ generate_all });
    export!(Component);
}

use bindings::exports::wasi::http::incoming_handler::Guest;
use bindings::wasi::http::types::*;
use bindings::wasmcloud::example::system_info;

struct Component;

impl Guest for Component {
    fn handle(_request: IncomingRequest, response_out: ResponseOutparam) {
        let call_result = system_info::call();

        // Build response body
        let response = OutgoingResponse::new(Fields::new());
        response.set_status_code(200).unwrap();
        let response_body = response.body().unwrap();
        ResponseOutparam::set(response_out, Ok(response));
        response_body
            .write()
            .unwrap()
            .blocking_write_and_flush(format!("{call_result:#?}").as_bytes())
            .unwrap();
        OutgoingBody::finish(response_body, None).expect("failed to finish response body");
    }
}
