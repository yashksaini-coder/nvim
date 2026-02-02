int pow(int a, int b, int M) {
	if (!b) return 1 % M;
	long long ans = pow(a, b / 2, M);
	ans = (ans * ans) % M;
	if (b & 1) ans = (ans * a) % M;
	return (int)ans;
}
