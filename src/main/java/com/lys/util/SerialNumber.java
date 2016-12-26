package com.lys.util;

public abstract class SerialNumber {
	
	public synchronized String getSerialNumber() {
		return process();
	}

	protected abstract String process();
}
