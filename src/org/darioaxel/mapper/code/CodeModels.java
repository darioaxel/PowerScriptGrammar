package org.darioaxel.mapper.code;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Properties;

import org.darioaxel.mapper.IMapperElementRepository;
import org.darioaxel.mapper.KDMElementFactory;
import org.darioaxel.mapper.source.listener.SourceFileListener;
import org.darioaxel.mapper.source.walker.InventoryModelWalker;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.NullProgressMonitor;
import org.eclipse.core.runtime.OperationCanceledException;
import org.eclipse.gmt.modisco.omg.kdm.code.CodeModel;
import org.eclipse.gmt.modisco.omg.kdm.code.LanguageUnit;
import org.eclipse.gmt.modisco.omg.kdm.source.InventoryModel;

public class CodeModels {	
				
	public static CodeModel create(IMapperElementRepository elementRepository, final InventoryModel inventoryModel, final Properties prop, IProgressMonitor monitor) {
		
		int toPhase = Integer.valueOf(prop.getProperty("PhasesToGenerate"));
		final CodeModel codeModel = KDMElementFactory.createCodeModel("");
		final List<LanguageUnit> languagesUsed = new ArrayList<LanguageUnit>();
		
		if (monitor == null) monitor = new NullProgressMonitor();
	
		monitor.beginTask("Extracting code model from inventory model...", 1);
		try {
			if (monitor.isCanceled()) throw new OperationCanceledException();
			
			if (toPhase > 1)
				phase1(elementRepository, inventoryModel, codeModel, languagesUsed, monitor);
			if (toPhase > 2)
				phase2(elementRepository, inventoryModel, codeModel, monitor);

		} finally {
			monitor.done();
		}
		
		return null;
	}	
	
	private static void phase2(IMapperElementRepository elementRepository,	InventoryModel inventoryModel, CodeModel codeModel, IProgressMonitor monitor) {
		// TODO Auto-generated method stub
		
	}

	private static void phase1(IMapperElementRepository elementRepository, final InventoryModel inventoryModel, final CodeModel codeModel, final List<LanguageUnit> languages, IProgressMonitor monitor) {
		
		final InventoryModelWalker phase1walker = elementRepository.getPhase1InventoryModelWalker(inventoryModel, codeModel);
		
		SourceFileListener sourceFileListener = elementRepository.getPhase1SourceFileListener();
		phase1walker.setSourceFileListener(sourceFileListener);
		monitor.subTask("Beggining phase 1 ...");		
		phase1walker.walk();
		monitor.subTask("Ending phase 1 ..");
	}
}
