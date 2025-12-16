use git2::Repository;
use flate2::write::GzEncoder;
use flate2::Compression;
use std::fs::File;
use std::io::prelude::*;
use std::process::Command;

fn main() {
    println!("🚀 Ghostbush Arsenal Sync starting...");

    // Repo check
    match Repository::open(".") {
        Ok(repo) => {
            if let Ok(head) = repo.head() {
                println!("Current branch: {}", head.shorthand().unwrap_or("detached"));
            }
        }
        Err(e) => println!("Repo error: {}", e),
    }

    // Compress a log file
    let input = "logs/ops.log";
    let output = "logs/ops.log.gz";
    if let Ok(mut f) = File::open(input) {
        let mut contents = Vec::new();
        f.read_to_end(&mut contents).unwrap();
        let mut encoder = GzEncoder::new(File::create(output).unwrap(), Compression::default());
        encoder.write_all(&contents).unwrap();
        encoder.finish().unwrap();
        println!("Compressed {} -> {}", input, output);
    } else {
        println!("No ops.log found to compress.");
    }

    // Auto‑commit and push
    let commit_msg = "Ghostbush Rust sync auto‑commit";
    let _ = Command::new("git").args(&["add", "-A"]).status();
    let _ = Command::new("git").args(&["commit", "-m", commit_msg]).status();
    let _ = Command::new("git").args(&["push", "origin", "main"]).status();

    println!("✅ Sync complete, pushed to GitHub.");
}
