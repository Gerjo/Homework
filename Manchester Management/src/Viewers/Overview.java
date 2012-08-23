package Viewers;

import Controllers.GUIController;
import Models.*;
import Models.PlayerModel;
import java.util.Vector;

public class Overview extends javax.swing.JPanel {
    private TablePlayers tablePlayers;
    private listTeams listTeams;
    private GUIController GUIController;

    public Overview(GUIController GUIController) {
        this.GUIController = GUIController;

        tablePlayers    = new TablePlayers(GUIController.getDataAccessObject());
        listTeams    = new listTeams(GUIController.getDataAccessObject());

        initComponents();
    }

    public TeamModel getSelectedTeam() {
        return listTeams.getTeamModelAt(teamList.getSelectedIndex());
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jTabbedPane1 = new javax.swing.JTabbedPane();
        jMenuBar1 = new javax.swing.JMenuBar();
        jMenu1 = new javax.swing.JMenu();
        jMenu2 = new javax.swing.JMenu();
        jLabel9 = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        jPanel1 = new javax.swing.JPanel();
        jScrollPane2 = new javax.swing.JScrollPane();
        teamList = new javax.swing.JList();
        addNewTeamButton = new javax.swing.JButton();
        deleteTeamButton = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        playerTable = new javax.swing.JTable();
        deleteTeamButton1 = new javax.swing.JButton();
        deleteTeamButton2 = new javax.swing.JButton();

        jMenu1.setText("File");
        jMenuBar1.add(jMenu1);

        jMenu2.setText("Edit");
        jMenuBar1.add(jMenu2);

        setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

        jLabel9.setFont(new java.awt.Font("Thames", 0, 36));
        jLabel9.setForeground(new java.awt.Color(204, 0, 51));
        jLabel9.setText("Manchester United");

        jLabel10.setText("Management Tool");

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder("Teams"));

        teamList.setModel(listTeams);
        teamList.addListSelectionListener(new javax.swing.event.ListSelectionListener() {
            public void valueChanged(javax.swing.event.ListSelectionEvent evt) {
                teamListValueChanged(evt);
            }
        });
        jScrollPane2.setViewportView(teamList);

        addNewTeamButton.setText("Add New Team");
        addNewTeamButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                addNewTeamButtonActionPerformed(evt);
            }
        });

        deleteTeamButton.setText("Delete Selected");
        deleteTeamButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                deleteTeamButtonActionPerformed(evt);
            }
        });

        jLabel1.setIcon(new javax.swing.ImageIcon("C:\\svn\\Netbeans\\Manchester\\src\\Resources\\united_logo.png")); // NOI18N

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addContainerGap()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(addNewTeamButton, javax.swing.GroupLayout.DEFAULT_SIZE, 125, Short.MAX_VALUE)
                            .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 125, Short.MAX_VALUE)
                            .addComponent(deleteTeamButton, javax.swing.GroupLayout.DEFAULT_SIZE, 125, Short.MAX_VALUE)))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGap(33, 33, 33)
                        .addComponent(jLabel1)))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 209, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(addNewTeamButton)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(deleteTeamButton)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jLabel1)
                .addContainerGap(44, Short.MAX_VALUE))
        );

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder("Players Available"));

        playerTable.setModel(tablePlayers);
        jScrollPane1.setViewportView(playerTable);

        deleteTeamButton1.setText("Delete Selected");
        deleteTeamButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                deleteTeamButton1ActionPerformed(evt);
            }
        });

        deleteTeamButton2.setText("Add New Player");
        deleteTeamButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                deleteTeamButton2ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 379, Short.MAX_VALUE)
                        .addContainerGap())
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addComponent(deleteTeamButton2, javax.swing.GroupLayout.DEFAULT_SIZE, 125, Short.MAX_VALUE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(deleteTeamButton1, javax.swing.GroupLayout.DEFAULT_SIZE, 125, Short.MAX_VALUE)
                        .addGap(133, 133, 133))))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 301, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(deleteTeamButton2)
                    .addComponent(deleteTeamButton1))
                .addContainerGap(69, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel9)
                        .addGap(10, 10, 10)
                        .addComponent(jLabel10))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel10)
                    .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
    }// </editor-fold>//GEN-END:initComponents

    private void addNewTeamButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_addNewTeamButtonActionPerformed
        GUIController.showAddTeam();
    }//GEN-LAST:event_addNewTeamButtonActionPerformed

    private void deleteTeamButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_deleteTeamButtonActionPerformed
        GUIController.getDataAccessObject().deleteTeams(listTeams.getElementAt(teamList.getSelectedIndices()));
        listTeams.reload();
        
    }//GEN-LAST:event_deleteTeamButtonActionPerformed

    private void deleteTeamButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_deleteTeamButton1ActionPerformed
        Vector<Integer> selectedModelIndices = new Vector<Integer>();

        for(int index : playerTable.getSelectedRows()) {
            selectedModelIndices.add(tablePlayers.getModelAt(index).getPlayerid());
        }

        GUIController.getDataAccessObject().deletePlayers(selectedModelIndices.toArray());
        tablePlayers.showOnlyByTeam();
    }//GEN-LAST:event_deleteTeamButton1ActionPerformed

    private void deleteTeamButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_deleteTeamButton2ActionPerformed
        GUIController.showAddPlayer();
    }//GEN-LAST:event_deleteTeamButton2ActionPerformed

    private void teamListValueChanged(javax.swing.event.ListSelectionEvent evt) {//GEN-FIRST:event_teamListValueChanged
        tablePlayers.showOnlyByTeam(getSelectedTeam());
    }//GEN-LAST:event_teamListValueChanged

    public TablePlayers getTablePlayers() {
        return tablePlayers;
    }

    public listTeams getListTeams() {
        return listTeams;
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton addNewTeamButton;
    private javax.swing.JButton deleteTeamButton;
    private javax.swing.JButton deleteTeamButton1;
    private javax.swing.JButton deleteTeamButton2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JMenu jMenu1;
    private javax.swing.JMenu jMenu2;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JTable playerTable;
    private javax.swing.JList teamList;
    // End of variables declaration//GEN-END:variables

}
