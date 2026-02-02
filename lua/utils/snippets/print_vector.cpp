template<typename T>
ostream& operator<<(ostream& os, vector<T> a) {
	if (!a.size()) os << "[]";
	else {
		os << '[' << a[0];
		for (size_t i = 1; i < a.size(); i++) os << ',' << a[i];
		os << "]\n";
	}
	return os;
}
