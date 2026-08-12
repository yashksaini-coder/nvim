use std::io;

fn solve() {}

fn main() {
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("read");
    let mut t: i32 = input.trim().parse().expect("parse");
    while t > 0 {
        solve();
        t -= 1;
    }
}
