package org.darioaxel.mapper;

import java.util.Collection;

import org.darioaxel.mapper.code.listener.PowerscriptPhase1Listener;
import org.darioaxel.mapper.code.parser.TypeParser;
import org.darioaxel.mapper.source.listener.FileListener;
import org.darioaxel.mapper.source.listener.InventoryModelFileListener;
import org.darioaxel.mapper.source.listener.SourceFileListener;
import org.darioaxel.mapper.source.walker.InventoryModelWalker;
import org.eclipse.gmt.modisco.omg.kdm.code.CodeModel;
import org.eclipse.gmt.modisco.omg.kdm.source.Directory;
import org.eclipse.gmt.modisco.omg.kdm.source.InventoryModel;

public interface IMapperElementRepository {
	
	 PowerscriptPhase1Listener getPhase1SourceFileListener();
	 SourceFileListener getPhase2SourceFileListener();
	 InventoryModelFileListener getInventoryModelFileListener(Directory root, Collection<String> languagesUsed);
	 InventoryModelWalker getPhase1InventoryModelWalker(InventoryModel inventoryModel);
	 TypeParser getSouceFileParser();
	 InventoryModelWalker getPhase2InventoryModelWalker(InventoryModel inventoryModel);
	 PowerscriptPhase1Listener getPhase1SourceFileListener(CodeModel codeModel);
}
