package org.darioaxel.mapper.code.listener;

import org.darioaxel.grammar.powerscript.powerscriptBaseListener;
import org.darioaxel.grammar.powerscript.powerscriptParser;
import org.darioaxel.mapper.KDMElementFactory;
import org.darioaxel.util.enums.EPowerscriptFileTypes;
import org.eclipse.gmt.modisco.omg.kdm.code.ClassUnit;
import org.eclipse.gmt.modisco.omg.kdm.code.CodeModel;
import org.eclipse.gmt.modisco.omg.kdm.code.CompilationUnit;
import org.eclipse.gmt.modisco.omg.kdm.source.SourceFile;

public class PowerscriptPhase1Listener extends powerscriptBaseListener {
	
	private final CodeModel internalModel = KDMElementFactory.createCodeModel("");
	private ClassUnit classUnit = null;
	private String compilationUnitName = "";
	private CompilationUnit compilationUnit = null;
	private boolean inForward = false;
	
	public CompilationUnit getCompilationUnit() {
		return (CompilationUnit) internalModel.getCodeElement().get(0);
	}
	
	public void setCompilationUnit(SourceFile source) {
		compilationUnitName = source.getName();
		compilationUnit = KDMElementFactory.createCompilationUnit(source);
		internalModel.getCodeElement().add(compilationUnit);		
	}
	
	@Override
	public void enterForwardDeclaration(powerscriptParser.ForwardDeclarationContext ctx) { 
		inForward = true;
	}
	
	@Override
	public void exitTypeDeclarationBegin(powerscriptParser.TypeDeclarationBeginContext ctx) { 
		if (inForward == true) {
			if(ctx.getChild(0).getText().equals("global")) {
				String className = ctx.getChild(1).getChild(1).toString();
				if (!compilationUnit.equals(null)) {
					classUnit = KDMElementFactory.createClass(className, typePowerscriptObjectIdentification(compilationUnitName));
					compilationUnit.getCodeElement().add(classUnit);
				}
				inForward = false;
			}			
		}		
	}	
	
	private EPowerscriptFileTypes typePowerscriptObjectIdentification(String fileName) {

		int lastIndexOf = fileName.lastIndexOf('.');
		String fileExt = fileName.substring(lastIndexOf + 1).toLowerCase();
		
		for(EPowerscriptFileTypes ep : EPowerscriptFileTypes.values()) {
			if (ep.extension().equals(fileExt)) {
				return ep;
			}
		}
		
		return EPowerscriptFileTypes.Unknown;
	}
}
