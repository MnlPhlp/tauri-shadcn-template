use tauri::AppHandle;
use tauri_plugin_pinia::ManagerExt;

#[tauri::command]
#[specta::specta]
fn greet(name: &str) -> String {
    format!("Hello, {name}! You've been greeted from Rust!")
}

#[tauri::command]
#[specta::specta]
fn greet_from_store(app: AppHandle) {
    let name = app.pinia().try_get::<String>("message", "name").unwrap();
    let msg = format!("Hello, {name}! You've been greeted from Rust using the store!");
    app.pinia().set("message", "greetMsg", msg).unwrap();
}

#[allow(clippy::missing_panics_doc)]
#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    let builder = tauri_specta::Builder::<tauri::Wry>::new()
        // Then register them (separated by a comma)
        .commands(tauri_specta::collect_commands![greet, greet_from_store]);

    #[cfg(all(debug_assertions, desktop))] // <- Only export on non-release builds
    builder
        .export(
            specta_typescript::Typescript::default(),
            "../src/bindings.ts",
        )
        .expect("Failed to export typescript bindings");

    tauri::Builder::default()
        .plugin(tauri_plugin_shell::init())
        .plugin(tauri_plugin_pinia::init())
        // and finally tell Tauri how to invoke them
        .invoke_handler(builder.invoke_handler())
        .setup(move |app| {
            // This is also required if you want to use events
            builder.mount_events(app);

            Ok(())
        })
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
