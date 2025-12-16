fn main() {
    println!("cargo:rustc-link-lib=Advapi32");
    println!("cargo:rustc-link-lib=Crypt32");
    println!("cargo:rustc-link-lib=User32");
    println!("cargo:rustc-link-lib=Kernel32");
}
