! function (t) {
	t(function () {
		function i(t, i, n) {
			var e = new Date;
			e.setTime(e.getTime() + 24 * n * 60 * 60 * 1e3);
			var g = "expires=" + e.toUTCString();
			document.cookie = t + "=" + i + ";" + g + ";path=/"
		}

		function n(t) {
			for (var i = t + "=", n = document.cookie.split(";"), e = 0; e < n.length; e++) {
				for (var g = n[e];
					" " == g.charAt(0);) g = g.substring(1);
				if (0 == g.indexOf(i)) return g.substring(i.length, g.length)
			}
			return ""
		}

		function e() {
			var n = [];
			t(".toggle-right").each(function (i) {
				n[i] = [], t(this).find(".right_hidden_inner").each(function (e) {
					t(this).is(":visible") && n[i].push(e)
				})
			}), i("toggle-right", JSON.stringify(n), 365)
		}

		function g() {
			var i = n("toggle-right");
			if (i) {
				var e, g = JSON.parse(i);
				t.each(g, function (i, n) {
					t.each(n, function (n, g) {
						e = t(".toggle-right").eq(i).find(".right_hidden_inner").eq(g), e.prev(".toggle-click").addClass("open"), e.animate({
							width: "toggle"
						}, 0)
					})
				})
			}
		}
		t(".toggle-click").click(function (i) {
			i.preventDefault(), t(this).toggleClass("open"), t(this).next(".right_hidden_inner").animate({
				width: "toggle"
			}, function () {
				e()
			})
		}), g()
	})
}(jQuery);
