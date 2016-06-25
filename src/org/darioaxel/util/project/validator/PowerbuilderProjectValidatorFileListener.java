package org.darioaxel.util.project.validator;

import java.io.File;


import org.darioaxel.util.IFileListener;

import org.darioaxel.util.FileAccess;

public class PowerbuilderProjectValidatorFileListener implements IFileListener{

	private  File pbtFile = null;
		
	@Override
	public void updateFile(File dir, File file) {
		
		if (isPBTConfigurationFile(file)) {
			pbtFile = file;
		}		
	}

	@Override
	public void enterDir(File parent, File dir) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void exitDir(File parent, File dir) {
		// TODO Auto-generated method stub
		
	}
	
	private boolean isPBTConfigurationFile(final File file) {
		String fileExt = FileAccess.getFileExtension(file);
		return fileExt.equals("pbt");
	}		
}
