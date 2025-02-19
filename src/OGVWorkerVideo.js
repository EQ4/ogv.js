proxy = new OGVWorkerSupport([
	'loadedMetadata',
	'videoFormat',
	'frameBuffer'
], {
	init: function(args, callback) {
		this.target.init(callback);
	},

	processHeader: function(args, callback) {
		this.target.processHeader(args[0], function(ok) {
			callback([ok]);
		});
	},

	processFrame: function(args, callback) {
		this.target.processFrame(args[0], function(ok) {
			callback([ok]);
		});
	}
});
