long long extended_gcd(long long a, long long b, vector<pair<long long, long long>>& hist) {
	hist.push_back({a, b});
	if (!b) return a;
	return extended_gcd(b, a % b, hist);
}

pair<long long, long long> extended_euclid(long long a, long long b) {
	vector<pair<long long, long long>> hist;
	long long g = extended_gcd(a, b, hist);
	bool order = a > b;
	long long a_ = hist.back().first, b_ = 0, x = 1, y = 1;
	for (long long i = hist.size() - 2; i >= 0; i--) {
		long long na = hist[i].first, nb = hist[i].second;
		if (a_ < b_) swap(a_, b_), swap(x, y);
		long long q = na / nb;
		x -= q * y;
		b_ = na;
	}
	if (a_ < b_) swap(x, y);
	if (!order) swap(x, y);
	return {x, y};
}

pair<long long, long long> diophantine(long long a, long long b, long long c) {
	long long g = gcd(a, b);
	if (c % g) return {0, 0};
	auto [x, y] = extended_euclid(a, b);
	return {x * (c / g), y * (c / g)};
}
