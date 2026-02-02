vector<pair<long long, long long>> factorise(long long n) {
	vector<pair<long long, long long>> res;
	for (long long i = 2; i * i <= n; i++) {
		if (!(n % i)) {
			res.push_back({i, 0});
			while (!(n % i)) n /= i, res.back().second++;
		}
	}
	if (n > 1) res.push_back({n, 1});
	return res;
}

long long pow_mod(long long n, long long e, long long m) {
	if (e == 0) return 1;
	if (e == 1) return n % m;
	long long half = pow_mod(n, e / 2, m);
	long long full = (half * half) % m;
	return (e & 1) ? (full * n) % m : full;
}

long long inverse(long long x, long long m) {
	long long g = gcd(x, m);
	if (g != 1) return 0;
	long long totient = 1;
	for (auto [p, exp] : factorise(m))
		totient *= pow_mod(p, exp - 1, m) * (p - 1);
	return pow_mod(x, totient - 1, m);
}
